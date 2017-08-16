#!/usr/bin/env python

import sys
import json
import os
import argparse
import textwrap
import csv
import inspect


def ontology_lookup(name, table):
    # takes in accession number outputs the name
    filename = inspect.getframeinfo(inspect.currentframe()).filename
    path = os.path.dirname(os.path.abspath(filename))


    # check if correct table
    if table=="role":
        tablepth = os.path.join(path, 'pub_role.loc')
    elif table=="status":
        tablepth = os.path.join(path, 'pub_status.loc')
    else:
        print "Table not recognised"
        return ""

    with open(tablepth, "rb") as csvfile:
        reader = csv.reader(csvfile, delimiter='\t')
        ont_dict = dict((k, v) for v, k in reader)
        try:
            return ont_dict[name]
        except KeyError:
            return ""



def main():

    p = argparse.ArgumentParser(prog='PROG',
                                formatter_class=argparse.RawDescriptionHelpFormatter,
                                description='''DI-MS processing for DMA''',
                                epilog=textwrap.dedent('''\
                            -------------------------------------------------------------------------
                            '''))


    p.add_argument('-inputzip', dest='inputzip', required=True)
    p.add_argument('-out_dir', dest='out_dir', required=True)
    p.add_argument('-html_file', dest='html_file', required=True)
    p.add_argument('-study_title', dest='study_title', required=True)

    p.add_argument('-jsontxt', dest='jsontxt', required=False, nargs='?')

    p.add_argument('--s_submission_date', dest='s_submission_date', required=False, default="", nargs='?')
    p.add_argument('--s_release_date', dest='s_release_date', required=False, default="", nargs='?')
    p.add_argument('--s_description', dest='s_description', required=False, default="", nargs='?')
    p.add_argument('--s_pubmed', dest='s_pubmed', required=False, default="", nargs='?')
    p.add_argument('--s_pub_doi', dest='s_pub_doi', required=False, default="", nargs='?')
    p.add_argument('--s_pub_status', dest='s_pub_status', required=False, default="", nargs='?')
    p.add_argument('--s_pub_author', dest='s_pub_author', required=False, default="", nargs='?')
    p.add_argument('--s_pub_title', dest='s_pub_title', required=False, default="", nargs='?')
    p.add_argument('--s_first_name', dest='s_first_name', required=False, default="", nargs='?')
    p.add_argument('--s_mid_initials', dest='s_mid_initials', required=False, default="", nargs='?')
    p.add_argument('--s_last_name', dest='s_last_name', required=False, default="", nargs='?')
    p.add_argument('--s_telephone', dest='s_telephone', required=False, default="", nargs='?')
    p.add_argument('--s_fax', dest='s_fax', required=False, default="", nargs='?')
    p.add_argument('--s_affiliation', dest='s_affiliation', required=False, default="", nargs='?')
    p.add_argument('--s_role', dest='s_role', required=False, default="", nargs='?')
    p.add_argument('--s_mail', dest='s_mail', required=False, default="", nargs='?')
    p.add_argument('--s_address', dest='s_address', required=False, default="", nargs='?')
    p.add_argument('--i_submission_date', dest='i_submission_date', required=False, default="", nargs='?')
    p.add_argument('--i_release_date', dest='i_release_date', required=False, default="", nargs='?')
    p.add_argument('--i_description', dest='i_description', required=False, default="", nargs='?')
    p.add_argument('--i_pubmed', dest='i_pubmed', required=False, default="", nargs='?')
    p.add_argument('--i_pub_doi', dest='i_pub_doi', required=False, default="", nargs='?')
    p.add_argument('--i_pub_title', dest='i_pub_title', required=False, default="", nargs='?')
    p.add_argument('--i_pub_status', dest='i_pub_status', required=False, default="", nargs='?')
    p.add_argument('--i_pub_author', dest='i_pub_author', required=False, default="", nargs='?')
    p.add_argument('--i_first_name', dest='i_first_name', required=False, default="", nargs='?')
    p.add_argument('--i_mid_initials', dest='i_mid_initials', required=False, default="", nargs='?')
    p.add_argument('--i_last_name', dest='i_last_name', required=False, default="", nargs='?')
    p.add_argument('--i_telephone', dest='i_telephone', required=False, default="", nargs='?')
    p.add_argument('--i_fax', dest='i_fax', required=False, default="", nargs='?')
    p.add_argument('--i_affiliation', dest='i_affiliation', required=False, default="", nargs='?')
    p.add_argument('--i_role', dest='i_role', required=False, default="", nargs='?')
    p.add_argument('--i_mail', dest='i_mail', required=False, default="", nargs='?')
    p.add_argument('--i_address', dest='i_address', required=False, default="", nargs='?')
    p.add_argument('--organism_text', dest='organism_text', required=False, default="", nargs='?')
    p.add_argument('--organism_ref', dest='organism_ref', required=False, default="", nargs='?')
    p.add_argument('--organism_iri', dest='organism_iri', required=False, default="", nargs='?')
    p.add_argument('--organism_part_text', dest='organism_part_text', required=False, default="", nargs='?')
    p.add_argument('--organism_part_ref', dest='organism_part_ref', required=False, default="", nargs='?')
    p.add_argument('--organism_part_iri', dest='organism_part_iri', required=False, default="", nargs='?')
    p.add_argument('--organism_variant_text', dest='organism_variant_text', required=False, default="", nargs='?')
    p.add_argument('--organism_variant_ref', dest='organism_variant_ref', required=False, default="", nargs='?')
    p.add_argument('--organism_variant_iri', dest='organism_variant_iri', required=False, default="", nargs='?')

    args = p.parse_args()

    USERMETA = {'characteristics': {'organism': {'name': '', 'accession': '', 'ref': ''},
                                    'organism_variant': {'name': '', 'accession': '', 'ref': ''},
                                    'organism_part': {'name': '', 'accession': '', 'ref': ''},
                                    },
                'investigation': {'identifier': '', 'title': 'Investigation', 'description': '',
                                  'submission_date': '', 'release_date': ''
                                  },
                'investigation_publication': {'pubmed': '', 'doi': '', 'author_list': '', 'title': '',
                                              'status': {'name': '', 'accession': '', 'ref': 'PSO'},
                                              },

                'study': {
                    'title': '', 'description': '', 'submission_date': '', 'release_date': '',
                },
                'study_publication': {'pubmed': '', 'doi': '', 'author_list': '', 'title': '',
                                      'status': {'name': '', 'accession': '', 'ref': 'PSO'},
                                      },

                'description': {'sample_collect': '', 'extraction': '', 'chroma': '', 'mass_spec': '',
                                'data_trans': '', 'metabo_id': ''
                                },

                # Multiple Values Parameters
                'study_contacts': [
                    {'first_name': '', 'last_name': '', 'mid': '', 'email': '',
                     'fax': '', 'phone': '', 'adress': '', 'affiliation': '',
                     'roles': {'name': '', 'accession': '', 'ref': ''},
                     },
                ],

                'investigation_contacts': [
                    {'first_name': '', 'last_name': '', 'mid': '', 'email': '',
                     'fax': '', 'phone': '', 'adress': '', 'affiliation': '',
                     'roles': {'name': '', 'accession': '', 'ref': ''},
                     },
                ],

                'Post Extraction': {'value': ''},
                'Derivatization': {'value': ''},
                'Chromatography Instrument': {'name': '', 'ref': '', 'accession': ''},
                'Column type': {'value': ''},
                'Column model': {'value': ''},
                }

    # check if using json file
    if args.jsontxt and os.path.isfile(args.jsontxt):
        with open(args.jsontxt, 'r') as f:
            USERMETA = json.load(f)
    else:

        # Fill in USERMETA dictionary
        USERMETA['characteristics']['organism']['value'] = args.organism_text
        USERMETA['characteristics']['organism']['accession'] = args.organism_iri
        USERMETA['characteristics']['organism']['ref'] = args.organism_ref

        USERMETA['characteristics']['organism_variant']['value'] = args.organism_variant_text
        USERMETA['characteristics']['organism_variant']['accession'] = args.organism_variant_iri
        USERMETA['characteristics']['organism_variant']['ref'] = args.organism_variant_ref

        USERMETA['characteristics']['organism_part']['value'] = args.organism_part_text
        USERMETA['characteristics']['organism_part']['accession'] = args.organism_part_iri
        USERMETA['characteristics']['organism_part']['ref'] = args.organism_part_ref

        # USERMETA['investigation']['identifier'] = # uses study identifier
        USERMETA['investigation']['description'] = args.i_description
        USERMETA['investigation']['submission_date'] = args.i_submission_date
        USERMETA['investigation']['release_date'] = args.i_release_date

        USERMETA['investigation_publication']['pubmed'] = args.i_pubmed
        USERMETA['investigation_publication']['author_list'] = args.i_pub_author
        USERMETA['investigation_publication']['title'] = args.i_pub_title
        USERMETA['investigation_publication']['doi'] = args.i_pub_doi
        USERMETA['investigation_publication']['status']['name'] = ontology_lookup(args.i_pub_status, 'status')
        USERMETA['investigation_publication']['status']['accession'] = args.i_pub_status

        USERMETA['investigation_contacts'][0]['first_name'] = args.i_first_name
        USERMETA['investigation_contacts'][0]['last_name'] = args.i_last_name
        USERMETA['investigation_contacts'][0]['mid'] = args.i_mid_initials
        USERMETA['investigation_contacts'][0]['email'] = args.i_mail
        USERMETA['investigation_contacts'][0]['fax'] = args.i_fax
        USERMETA['investigation_contacts'][0]['phone'] = args.i_telephone
        USERMETA['investigation_contacts'][0]['adress'] = args.i_address
        USERMETA['investigation_contacts'][0]['affiliation'] = args.i_affiliation
        USERMETA['investigation_contacts'][0]['roles']['name'] = ontology_lookup(args.i_role, 'role')
        USERMETA['investigation_contacts'][0]['roles']['accession'] = args.i_role

        USERMETA['study']['title'] = args.study_title
        USERMETA['study']['description'] = args.s_description
        USERMETA['study']['submission_date'] = args.s_submission_date
        USERMETA['study']['release_date'] = args.s_release_date

        USERMETA['study_publication']['pubmed'] = args.s_pubmed
        USERMETA['study_publication']['author_list'] = args.s_pub_author
        USERMETA['study_publication']['title'] = args.s_pub_title
        USERMETA['study_publication']['doi'] = args.s_pub_doi
        USERMETA['study_publication']['status']['name'] = ontology_lookup(args.s_pub_status, 'status')
        USERMETA['study_publication']['status']['accession'] = args.s_pub_status

        USERMETA['study_contacts'][0]['first_name'] = args.s_first_name
        USERMETA['study_contacts'][0]['last_name'] = args.s_last_name
        USERMETA['study_contacts'][0]['mid'] = args.s_mid_initials
        USERMETA['study_contacts'][0]['email'] = args.s_mail
        USERMETA['study_contacts'][0]['fax'] = args.s_fax
        USERMETA['study_contacts'][0]['phone'] = args.s_telephone
        USERMETA['study_contacts'][0]['adress'] = args.s_address
        USERMETA['study_contacts'][0]['affiliation'] = args.s_affiliation
        USERMETA['study_contacts'][0]['roles']['name'] = ontology_lookup(args.s_role, 'role')
        USERMETA['study_contacts'][0]['roles']['accession'] = args.s_role


    try:
        from mzml2isa.parsing import full_parse
        # import progressbar as pb
        # parse the files
        full_parse(args.inputzip, args.out_dir, args.study_title, usermeta=USERMETA, split=True, merge=False, verbose=True,
                   multip=False)

    except ImportError:
        import tempfile
        temp = tempfile.NamedTemporaryFile()
        temp.write(json.dumps(USERMETA))
        temp.seek(0)
        os.system("mzml2isa -i %s -o %s -s %s -m %s" % (args.inputzip, args.out_dir, args.study_title, temp.name))
        temp.close()

    html_code = '<a href="%s/a_%s_metabolite_profiling_mass_spectrometry.txt">a_%s_metabolite_profiling_mass_spectrometry.txt</a>' \
                '<br/><a href="%s/i_Investigation.txt">i_Investigation.txt</a><br/>' \
                '<a href="%s/s_%s.txt">s_test.txt</a><br/>' % tuple([args.study_title] * 6)

    with open(args.html_file, 'wb') as f:
        f.write(html_code)



if __name__ == "__main__":
    main()
