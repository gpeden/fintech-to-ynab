class YNAB::BulkTransactionCreator

  def initialize(transactions, budget_id: nil, account_id: nil)
    @transactions = transactions
    @client = YNAB::Client.new(ENV['YNAB_ACCESS_TOKEN'], budget_id, account_id)
    @batch_size = ENV['BATCH_SIZE']
    if @batch_size == nil
      then @batch_size = 20.freeze
    else
      @batch_size = Integer(@batch_size)
    end
  end

  def create
    if @transactions.size == 0
      Rails.logger.info(:no_transactions_to_create)
      return false
    end

    if @batch_size > 0
      batches = (@transactions.size.to_f / @batch_size).ceil
    else
      # Batch size <= 0 means 'no batching'
      batches = 1
      @batch_size = @transactions.size
    end

    Rails.logger.info("Splitting #{@transactions.size} transactions into #{batches} batches of #{@batch_size} transactions per batch")

    @transactions.each_slice(@batch_size).with_index do |transactions, index|
      Rails.logger.info("Processing batch #{index + 1} of #{batches}")

      transactions_to_create = []
      transactions.each do |transaction|
        transactions_to_create << {
          import_id: transaction[:id].to_s.truncate(36),
          account_id: @client.selected_account_id,
          payee_name: transaction[:payee_name].to_s.truncate(50),
          amount: transaction[:amount],
          memo: transaction[:description],
          date: transaction[:date].to_date,
          cleared: !!transaction[:cleared] ? 'Cleared' : 'Uncleared',
          flag: transaction[:flag]
        }
      end

      if transactions_to_create.any?
        Rails.logger.info(@client.create_transactions(transactions_to_create))
      else
        Rails.logger.info(:no_transactions_to_create)
      end
    end
  end
end
