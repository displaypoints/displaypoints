DeployBase.fixture {{
  :campaign       => Campaign.gen,
  :menu           => Menu.gen,
  :publish_group  => PublishGroup.gen
}}

given 'a deploy base => @deploy_base' do
  @deploy_base = DeployBase.gen
end