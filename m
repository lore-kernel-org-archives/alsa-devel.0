From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000877]: balance problem with ALC880 (Intel HD Audio)
Date: Wed, 2 Feb 2005 11:32:54 +0100
Message-ID: <244b982b2654d6184d3051ecb2bbfa36@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 39766211
	for <alsa-devel@alsa-project.org>; Wed,  2 Feb 2005 11:32:54 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=877> 
======================================================================
Reported By:                alphacc
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   877
Category:                   PCI - azx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Scientific Linux 3.03 (close to Redhat ES 3)
Kernel Version:             2.4.21
======================================================================
Date Submitted:             02-02-2005 11:32 CET
Last Modified:              02-02-2005 11:32 CET
======================================================================
Summary:                    balance problem with ALC880 (Intel HD Audio)
Description: 
module : snd-azx

When I try to change the Front balance (left/right), the Front volume is
going up or down randomly.
Tested with xmms, alsamixer, gnome-alsamixer.

Is it a known problem with other platforms / modules ?

======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-02-05 11:32 alphacc        New Issue                                    
02-02-05 11:32 alphacc        Distribution              => Scientific Linux 3.03
(close to Redhat ES 3)
02-02-05 11:32 alphacc        Kernel Version            => 2.4.21          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
