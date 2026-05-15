module BulkActions
  extend ActiveSupport::Concern

  def bulk_destroy(collection,redirect_path)
    ids = params[:ids].uniq
    records = collection.where(id: ids)
    count= records.size
    records.destroy_all
    redirect_to redirect_path, notice:"#{count} records(s) deleted"
  end

  def bulk_export(collection, filename_prefix,headers,row_builder)
    ids = params[:ids].uniq
    records = collection.where(id:ids)
    csv_data= CSV.generate(headers:true) do |csv|
            csv << headers
            records.each {|r| csv << row_builder.call(r)}
    end
    send_data csv_data,
              filename: "#{filename_prefix}-#{Date.today}.csv",
              type:"text/csv"
  end
end