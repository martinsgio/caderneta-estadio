// Configuração do Supabase.
// Copie os dois valores em Supabase → Project Settings → API (ou "Data API" / "API Keys").
// A chave "anon public" (ou "publishable") pode ficar pública: quem protege os dados
// são as regras de segurança (RLS) criadas pelo arquivo supabase.sql.
// NUNCA coloque aqui a chave "service_role" / "secret".
window.CADERNETA_CONFIG = {
  SUPABASE_URL: 'COLE_AQUI_A_PROJECT_URL',          // ex.: https://abcdefghijkl.supabase.co
  SUPABASE_ANON_KEY: 'COLE_AQUI_A_CHAVE_ANON_PUBLIC' // ex.: eyJhbGciOi... ou sb_publishable_...
};
