From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000776]: dissynchronization
Date: Sun, 2 Jan 2005 13:14:10 +0100
Message-ID: <152a029c36012369b1e72335240e16b3@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id F17C92D2
	for <alsa-devel@alsa-project.org>; Sun,  2 Jan 2005 13:14:10 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=776> 
======================================================================
Reported By:                SergeS
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   776
Category:                   PCI - nm256
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             2.4.28
======================================================================
Date Submitted:             01-02-2005 13:14 CET
Last Modified:              01-02-2005 13:14 CET
======================================================================
Summary:                    dissynchronization
Description: 
some times sound repeates bit
from MPlayer log
alsa-space: xrun of at least xx.xxxx msecs. resseting stream

if i run MPlayer with oss emulation - all is ok, when i try oss - all is
ok 

all software witch uses alsa do same error

hardwate: Dell Latitude CSx, NeoMagick NM256ZX
if need more information - send me email to sergesb@mail.ru
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-02-05 13:14 SergeS         New Issue                                    
01-02-05 13:14 SergeS         Kernel Version            => 2.4.28          
======================================================================




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
