DataDictionary
================

Data dictionary for the LOBSTAHS default database
-------------------------------------------------

### Astaxanthin

-   **astaxanthin** - [Astaxanthin](https://en.wikipedia.org/wiki/Astaxanthin)
    -   Actively researched because important pharmaceutical

### Bile Salts

Steroid-like molecules produced in bile to break down stubborn molecules. Note the differences in -OH group location between these 3

-   **lithocholic\_acid** - [Lithocholic acid](https://en.wikipedia.org/wiki/Lithocholic_acid)
-   **cholic\_acid** - [Cholic acid](https://en.wikipedia.org/wiki/Cholic_acid)
-   **deoxycholic\_acid** - [Deoxycholic acid](https://en.wikipedia.org/wiki/Deoxycholic_acid)

### DNPPE

-   **DNPPE** - [Dinitrophenol-phosphatidylethanolamine](https://avantilipids.com/product/810508)
    -   1,2-dipalmitoyl-sn-glycero-3-phosphoethanolamine-N-(2,4-dinitrophenyl)
    -   Artificial lipid synthesized and added to samples, used to normalize compounds

### Fungal glycopsphingolipids

Produced by fungus. Should be rare in our samples. Good example of an improperly- imported dataset.

-   **fngGSL series**
    -   fngGSL(14:0\_OH)
    -   fngGSL(14:1\_OH)
    -   fngGSL(15:0\_OH)
    -   fngGSL(15:1\_OH)
    -   fngGSL(16:0\_OH)
    -   fngGSL(16:1\_OH)
    -   fngGSL(17:0\_OH)
    -   fngGSL(17:1\_OH)
    -   fngGSL(18:0\_OH)
    -   fngGSL(18:1\_OH)
    -   fngGSL(19:0\_OH)
    -   fngGSL(19:1\_OH)
    -   fngGSL(20:0\_OH)
    -   fngGSL(20:1\_OH)

### Haptophyte ceramides

[Ceramides](https://en.wikipedia.org/wiki/Ceramide) from haptophytes (probably coccolithophores). Ceramides are a [sphingolipid](https://en.wikipedia.org/wiki/Sphingosine) connected head-on to a fatty acid via an amide bond.

-   **hapCER(d18:1/22:0(OH))**
-   **hapCER(d18:1/22:1(OH))**

### Haptophyte glycopsphingolipids

[Glycosphingolipids](https://en.wikipedia.org/wiki/Glycosphingolipid) from haptophytes (probably coccolithophores, probably [E. hux](https://en.wikipedia.org/wiki/Emiliania_huxleyi)). Glycosphingolipids are a sphingolipid with an attached sugar/carbohydrate group

-   **hapGSL(t40:0)**
-   **hapGSL(t40:1)**
-   **hGSL** (probably belongs here? Will is not sure.)
-   **vGSL** (maybe here?)
-   **sGSL** (maybe here?)

### Intact polar diacylglycerides

Better known as membrane lipids, this group contains the classic [phospholipids](https://en.wikipedia.org/wiki/Phospholipid) and their derivatives. Diacylglycerides (di- acyl- glycer- ides) are composed of two (di) fatty acid (acyl) chains and a [glycerol](https://en.wikipedia.org/wiki/Glycerol) (glycer) backbone. The head group, or the third branch on the backbone, is the main source of distinction for this group. See [Popendorf *et al* (2011)](https://doi.org/10.1016/j.orggeochem.2011.05.003) and Kim Popendorf's thesis (in the Reading List) for an overview and structures.

[Betaine](https://en.wikipedia.org/wiki/Betaine) lipids are named after the beets they were originally found in. Nitrogen containing, can be swapped in for phospholipids under phosphorus stress. See [Van Mooy *et al* (2009)](https://www.nature.com/articles/nature07659) for a summary.

-   **BLL** - General betaine-like lipids.
-   **DGCC** - Specific BLL. Properly known as diacylglycerylcarboxyhydroxymethylcholine.
-   **S\_DGCC** - ??? Probably some form of DGCC.
-   **DGTS\_DGTA** - Two specific BLLs, cannot be separated via the Van Mooy Lab mass spec setup because they're structural isomers and are thus grouped together. Properly known as diacylglyceryl-N,N,N-trimethylhomoserine and diacylglycerylhydroxymethyl-N,N,N-trimethyl β-alanine.

Glycolipids are lipid compounds with sugars as the headgroup.

-   **MGDG** - Specific glycolipid. Properly known as monogalactosyldiacylglycerides.
    -   Glycerol backbone with one (galactose) sugar attached
-   **DGDG** - Specific glycolipid. Properly known as digalactosyldiacylglycerides.
    -   Glycerol backbone with two (galactose) sugars attached
-   **SQDG** - Specific glycolipid. Properly known as sulfoquinovosyldiacylglycerides
    -   Glycerol backbone with a sulfur/sugar headgroup.
    -   Often used in comparison to PG as a measure of nutrient stress. ([Popendorf *et al*, 2011](https://doi.org/10.5194/bg-8-3733-2011))

Phospholipids have a phosphorus atom in the headgroup. Generally a sign of a nutrient-replete environment.

-   **PE** - Specific phospholipid. Properly known as phosphatidylethanolamine.
-   **PG** - Specific phospholipid. Properly known as phosphatidylglycerol.
-   **PC** - Specific phospholipid. Properly known as phosphatidylcholine.
-   **PDPT** - Specific phospholipid. Properly known as phosphatidyldimethylpropanethiol.
    -   Novel, [found by the Van Mooy lab in 2014](https://doi.org/10.1111/1462-2920.12358) in E. hux.
    -   Has been used as an indicator of viral stress.

Other stuff:

-   **DAG** - General diacylglyceride.
-   **WaxEster** - Two fatty acids connected via an ester bond.

### Intact polar monoacylglycerides

Similar to IP-DAGs, but have only one tail instead of two.

-   **CoprostanolEsters** - glycerol backbone, one long tail, and [coprostanol](https://en.wikipedia.org/wiki/Coprostanol) as a headgroup.
-   **CholesterolEsters** - glycerol backbone, one long tail, and [cholesterol](https://en.wikipedia.org/wiki/Cholesterol) as a headgroup.
-   **MAG** - General monoacylglyceride.
-   **L-series** - Lyso-whatever. The general structure of whatever follows (PE, DGCC, etc.) but only has one tail.
    -   LDGCC
    -   LDGDG
    -   LDGTS\_DGTA
    -   LPE
    -   LPG
    -   LPC
    -   LSQDG
    -   LMGDG

### Polydimethylsiloxane

This is sometimes used as a lock-mass, and artificially introduced into the samples by leaving a stick of deodorant open on top. Not actually in the samples collected, but instead added later like DNPPE.

-   **PDMS**
    -   The database contains 21 species of PDMS, labeled as PDMS6-PDMS27.

### Pigments

-   **Allox** - [Alloxanthin](https://pubchem.ncbi.nlm.nih.gov/compound/12305997#section=Top)
-   **Alpha\_carotene**
-   **Beta\_carotene**
-   **Chlorophylls**
    -   Yes, there are many many of these. 4 are identifed in the database.
    -   **Chl\_a** - generally scales with phytoplankton biomass, good to normalize to
    -   **Chl\_b**
    -   **Chl\_c2** - most common form
    -   **Chl\_c3** - found largely in E. hux
-   **Chlide\_a** - Chlorophyllide a, precursor to chlorophyll a. Everything except the long tail.
    -   Can also be a degradation product
-   **Croco** - run away, crocodiles found in sample.
    -   Just kidding, Will has no idea.
-   **Dd\_Ddc** - ??? also no idea. Despite the name, not deuterated. Possibly deoxygenated?
-   **Dt** - Will doesn't even know how to *start* looking this one up.
-   **Echin** - Probably [echinenone](https://en.wikipedia.org/wiki/Echinenone)
-   **Fuco** - [Fucoxanthin](https://en.wikipedia.org/wiki/Fucoxanthin). Found in brown algae (e.g. diatoms, kelps) and is responsible for their color
-   **Lut** - [Lutein](https://en.wikipedia.org/wiki/Lutein).
-   **Neox\_Nos** - Some form of [neoxanthin](https://en.wikipedia.org/wiki/Neoxanthin), a group of molecules used by the cell to reduce photooxidative stress
-   **Peri** - [Peridinin](https://www.sciencedirect.com/topics/agricultural-and-biological-sciences/peridinin).
-   **Pheophytin\_a** - Pheophytin a. A degradation product of chlorophyll.
-   **Pras** - [Prasinoxanthin](https://www.sciencedirect.com/science/article/abs/pii/S003194220083455X).
-   **Viol** - Violaxanthin
-   **Zeax** - Zeaxanthin

### [Plastoquinones](https://en.wikipedia.org/wiki/Plastoquinone)

Another good example of an improperly-imported dataset. Each lipid class has only a single species and a single compound, so they should be within another lipid class and all within the same species.

-   **PQ9** - most common form, also known as PQ-9 or PQ-A
-   **PQ9OH** - hydoxylated form of PQ-9
-   **PQ9OH2** - dihydroxylated form of PQ-9

### Polyunsaturated aldehydes

Better known as PUAs - ask Bethanie, she knows *everything* about these. Do be wary of the completely unsaturated (:0) and highly oxidized (+3O, +4O) compounds because they're difficult to make and may be poorly annotated.

-   **PUA**

### Scytonemin

A "cyanobacterial sunscreen", this compound is found in the cell membranes of cyanobacteria. There are two lipid classes here, reduced and regular, but both may show up in samples.

-   **scytonemin**
-   **reduced\_scytonemin**

### Sterol

Contains two species, both versions of cholesterol.

-   **CholesterolAcetate**
-   **Cholesterol2H**

### Triacylglycerides

Shortened to be "TAGs", [these molecules](https://en.wikipedia.org/wiki/Triglyceride) serve as the energy reserves of the cell as they are able to produce fatty acids for [beta-oxidation](https://en.wikipedia.org/wiki/Beta_oxidation) and the [Krebs cycle](https://en.wikipedia.org/wiki/Citric_acid_cycle). These molecules are also highly prized because they can be esterified to produce biofuels. Their structure is a glycerol backbone in which all three slots have fatty acids. Veggie oil is one example of a triacylglyceride, as is butter. However, specific TAGs are poorly annotated in the database, and fall into two species.

-   **Trimyristin-d15** - a specific form of [trimyristin](https://en.wikipedia.org/wiki/Trimyristin)
-   **TAG** - general TAG molecule, usually with structural information.
