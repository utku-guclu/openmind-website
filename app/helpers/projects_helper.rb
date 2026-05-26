module ProjectsHelper
  def project_icon(category)
    case category
    when "education" then "graduation-cap"
    when "teaching" then "chalkboard-teacher"
    when "construction" then "hammer"
    when "it_training" then "code"
    else "heart-half"
    end
  end
end
