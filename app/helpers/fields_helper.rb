module FieldsHelper

  CATEGORY = %w{5 6 7 8 9 10 11}
  SURFACE = %w{sand grass parquet synthetic_grass land cement}
  DESCRIPTION = %w{roofed illuminated}

  def rent_button(form)
    if user_signed_in?
      form.submit t('.btn_rent'), class: 'btn btn-primary'
    else
      link_to t('.link_login'),
        new_user_session_path,
        class: 'btn btn-primary'
    end
  end

end
