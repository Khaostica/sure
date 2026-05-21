class DS::ProgressRing < DesignSystemComponent
  TONES = %i[success warning destructive neutral].freeze

  attr_reader :size, :stroke_width, :tone, :show_percent

  # Circular progress-ring primitive. Decoupled from any domain model —
  # callers pass `percent:` directly (0..100, clamped). Use `tone:` to map
  # a domain status to a semantic color token; `:neutral` is the default.
  #
  # ARIA: renders as `role="progressbar"` with `aria-valuenow/min/max` and
  # an `aria-label` (either caller-supplied via `label:` or the default
  # "<n>% complete" fallback).
  def initialize(percent:, size: 64, stroke_width: 6, tone: :neutral, label: nil, show_percent: false)
    @percent = percent.to_f.clamp(0, 100)
    @size = size.to_i
    @stroke_width = stroke_width.to_i
    @tone = TONES.include?(tone.to_sym) ? tone.to_sym : :neutral
    @label = label
    @show_percent = show_percent
  end

  def percent
    @percent.round
  end

  def radius
    (size - stroke_width) / 2.0
  end

  def center
    size / 2.0
  end

  def circumference
    2 * Math::PI * radius
  end

  def stroke_dashoffset
    ((100 - @percent) * circumference) / 100.0
  end

  def stroke_color
    case tone
    when :success then "var(--color-success)"
    when :warning then "var(--color-warning)"
    when :destructive then "var(--color-destructive)"
    else "var(--color-gray-500)"
    end
  end

  def track_color
    "light-dark(var(--color-gray-200), var(--color-gray-700))"
  end

  def percent_text_class
    case tone
    when :success then "text-success"
    when :destructive then "text-destructive"
    else "text-primary"
    end
  end

  def percent_text_size_class
    return "text-base" if size >= 48
    return "text-xs" if size >= 24
    "text-[10px]"
  end

  def aria_label
    @label.presence || I18n.t("ds.progress_ring.default_aria_label", percent: percent)
  end
end
