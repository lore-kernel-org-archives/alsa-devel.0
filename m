From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001008]: only one application can play at once
Date: Tue, 22 Mar 2005 22:15:18 +0100
Message-ID: <f090df3517e5d44ac6e21d745fcecf7a@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 975B8259
	for <alsa-devel@alsa-project.org>; Tue, 22 Mar 2005 22:15:18 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1008> 
======================================================================
Reported By:                msillence
Assigned To:                jcdutton
======================================================================
Project:                    ALSA - driver
Issue ID:                   1008
Category:                   PCI - ca0106
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             2.6.11.5
======================================================================
Date Submitted:             03-22-2005 22:15 CET
Last Modified:              03-22-2005 22:15 CET
======================================================================
Summary:                    only one application can play at once
Description: 
when two applications try and play or write to the dsp at the same time the
second  gets a device in use message.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-22-05 22:15 msillence      New Issue                                    
03-22-05 22:15 msillence      Kernel Version            => 2.6.11.5        
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: 2005 Windows Mobile Application Contest
Submit applications for Windows Mobile(tm)-based Pocket PCs or Smartphones
for the chance to win $25,000 and application distribution. Enter today at
http://ads.osdn.com/?ad_id=6882&alloc_id=15148&op=click
