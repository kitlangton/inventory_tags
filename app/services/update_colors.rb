class UpdateColors
  def call(params)
    params[:colors].each do |_, v|
      c = Color.find(v[:id])
      c.tags.each do |t|
        t.image.destroy
        ImageWorker.perform_async(t.id)
      end
      c.update(name: v[:name], hex: v[:hex], complete: true)
    end
  rescue
    [false, nil]
  else
    [true, nil]
  end
end
