-- ============================================================
-- IT Portaal — Kolommen toevoegen voor locatie
-- Plak dit in: Supabase → SQL Editor → Run
-- (Alleen nodig als je de tabel al eerder hebt aangemaakt)
-- ============================================================

ALTER TABLE public.it_verzoeken
  ADD COLUMN IF NOT EXISTS kamer text,
  ADD COLUMN IF NOT EXISTS etage text,
  ADD COLUMN IF NOT EXISTS plek  text;

-- ============================================================
-- OF: Maak de tabel volledig opnieuw aan (als je nog niets hebt)
-- ============================================================

CREATE TABLE IF NOT EXISTS public.it_verzoeken (
  id            bigserial PRIMARY KEY,
  created_at    timestamptz DEFAULT now() NOT NULL,
  naam          text NOT NULL,
  email         text NOT NULL,
  afdeling      text,
  categorie     text,         -- 'vip' of 'incident'
  onderwerp     text NOT NULL,
  omschrijving  text,
  prioriteit    text DEFAULT 'Laag',
  datum         text,         -- gewenste tijd (VIP) of incidentcategorie
  status        text DEFAULT 'Nieuw' NOT NULL,
  kamer         text,         -- kamernummer
  etage         text,         -- etage
  plek          text          -- plek / zone
);

ALTER TABLE public.it_verzoeken ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Publiek lezen"     ON public.it_verzoeken FOR SELECT USING (true);
CREATE POLICY "Publiek invoegen"  ON public.it_verzoeken FOR INSERT WITH CHECK (true);
CREATE POLICY "Publiek updaten"   ON public.it_verzoeken FOR UPDATE USING (true);
CREATE POLICY "Publiek verwijderen" ON public.it_verzoeken FOR DELETE USING (true);
