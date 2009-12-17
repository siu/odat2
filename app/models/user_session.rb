class UserSession < Authlogic::Session::Base
  include GetText

  disable_magic_states true
  generalize_credentials_error_messages N_('Los datos de inicio de sesión no son válidos')

  validate :login_permitted

  private
  def login_permitted
    # If the record was not found or it already contains errors return (don't show more information)
    return if attempted_record.nil? or errors.any?
    errors.add(:base, N_('El usuario no está activo')) and return false unless attempted_record.active?
    errors.add(:base, N_('El usuario no ha sido aprovado')) unless attempted_record.approved?
  end

end
