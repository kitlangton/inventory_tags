class UpdateColors
  def call(params)
    params[:colors].each do |_, v|
      c = Color.find(v[:id])
      if c.hex != v[:hex]
        c.update(hex: v[:hex])
        c.tags.each do |t|
          t.image.destroy
          ImageWorker.perform_async(t.id)
        end
      end
    end
  rescue
    [false, nil]
  else
    [true, nil]
  end
end
