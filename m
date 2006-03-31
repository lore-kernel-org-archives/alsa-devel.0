From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001984]: Line in record level impossible with OSS compatibility
Date: Fri, 31 Mar 2006 16:16:02 +0200
Message-ID: <78ddb993747a60a70745a4cb65170068@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id A76F516B
	for <alsa-devel@alsa-project.org>; Fri, 31 Mar 2006 16:16:02 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1984> 
======================================================================
Reported By:                croiset
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1984
Category:                   PCI - cmipci
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             03-31-2006 16:16 CEST
Last Modified:              03-31-2006 16:16 CEST
======================================================================
Summary:                    Line in record level impossible with OSS
compatibility
Description: 
it's impossible to adjust the analog input level by alsamixer except if you
use the "Line" fader. So when you record you always have the input on the
output.

It will be better if it's possible to use IGAIN.


======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-31-06 16:16 croiset        New Issue                                    
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
