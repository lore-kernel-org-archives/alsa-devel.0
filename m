From: Alex Song <asong@xvdcorp.com>
Subject: ATI IXP SPDIF
Date: Mon, 24 May 2004 16:16:42 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1649E0C057D17842BA917E5124BF331A15BD7A@as2.alaris.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "'alsa-devel@lists.sourceforge.net'" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

hi,

i am trying to get SPDIF output working on ATI IXP/Realtek ALC655 and i am
using atiixp.c from cvs (version 1.9) and linux kernel 2.6.5. i tried
playing back wav files through aplay and ac3 files with ac3play and i
couldn't get any output from either SPDIF over AC97 or SPDIF Direct. analog
output is fine. from the cvs logs i gather that SPDIF on ATI IXP should work
for some cases at least, has anyone got it to work? if so with what
files/hardware/settings etc?

i am not very familiar with sound programming or sound card driver
operation, but i am willing to help if needed.

cheers,

alex

=========================================
Alex Song
Software Engineer
XVD Corporation
44061 Nobel Drive
Fremont, CA 94538, USA
Work: (510) 770-5700 x266
Fax: (510) 770-5769
Email: asong@xvdcorp.com
========================================= 


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
