From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001687]: hda-intel 5.1 surround from digital out
Date: Wed, 28 Dec 2005 19:24:40 +0100
Message-ID: <ce178b89a49d316f6060b509552c7866@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 2BC2618E
	for <alsa-devel@alsa-project.org>; Wed, 28 Dec 2005 19:24:41 +0100 (MET)
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


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1687> 
======================================================================
Reported By:                1g0R
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1687
Category:                   PCI - hda-intel
Reproducibility:            have not tried
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               Fedora Core
Kernel Version:             2.6.14.3
======================================================================
Date Submitted:             12-28-2005 17:05 CET
Last Modified:              12-28-2005 19:24 CET
======================================================================
Summary:                    hda-intel 5.1 surround from digital out
Description: 
Hi,
I tried to make 5.1 surround sound from digital out, but unsuccess.
My receiver (onkyo), said its PCM sound.On windows the receiver says
DolbyDigital.
What i need to do ?
Thanks.
======================================================================

----------------------------------------------------------------------
 1g0R - 12-28-05 19:24 
----------------------------------------------------------------------
Aham,well i tried mplayer with that command:
mplayer video_with_ac3_audio.avi -ac hwac3 -ao alsa
and on receiver pcm has changed DolbyDigital.
How can i do that to default alsa spdif out?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-28-05 17:05 1g0R           New Issue                                    
12-28-05 17:05 1g0R           Distribution              => Fedora Core     
12-28-05 17:05 1g0R           Kernel Version            => 2.6.14.3        
12-28-05 19:24 1g0R           Note Added: 0007177                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
