class ProgressRingComponentPreview < ViewComponent::Preview
  # @param percent number
  # @param size number
  # @param stroke_width number
  # @param tone select ["neutral", "success", "warning", "destructive"]
  # @param show_percent toggle
  # @param label text
  def default(percent: 42, size: 64, stroke_width: 6, tone: "neutral", show_percent: true, label: nil)
    render DS::ProgressRing.new(
      percent: percent.to_f,
      size: size.to_i,
      stroke_width: stroke_width.to_i,
      tone: tone.to_sym,
      show_percent: show_percent,
      label: label
    )
  end

  def tones
    render_with_template
  end

  def holdings_inline_size
    render DS::ProgressRing.new(percent: 38, size: 16, stroke_width: 2)
  end
end
