From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000294]: Request for Echo Cards driver
Date: Thu, 13 Jan 2005 17:32:39 +0100
Message-ID: <9f6c6f58d2a38aa801891167347d8ad4@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 1299F29B
	for <alsa-devel@alsa-project.org>; Thu, 13 Jan 2005 17:32:39 +0100 (MET)
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


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=294> 
======================================================================
Reported By:                mantaraya36
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   294
Category:                   OTHERS
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     resolved
Distribution:               
Kernel Version:             
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             05-21-2004 17:53 CEST
Last Modified:              01-13-2005 17:32 CET
======================================================================
Summary:                    Request for Echo Cards driver
Description: 
Hi
(posted as well in the sourceforge request list-disregard if already
read)
I wrote a while ago requesting ALSA support for the
Echo Mona card, and the request was understandably
rejected since the card has been discontinued.
However, I had a quick look at the generic C++ drivers
available at www.echoaudio.com , and it seems that all
thier cards share the same driver so when creating a
driver for the Layla24 or the Mia card you would also
be creating a driver for the Mona.
Can you check this out and give it a though? I would
obviously be very pleased to help you test the drivers.

Thanks very much,
Andres
======================================================================

----------------------------------------------------------------------
 martin - 06-05-04 12:22 
----------------------------------------------------------------------
http://xoomer.virgilio.it/g_pochini/ea.html

----------------------------------------------------------------------
 tiwai - 01-13-05 17:32 
----------------------------------------------------------------------
Merged to ALSA 1.0.8.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-21-04 17:53 mantaraya36    New Issue                                    
05-25-04 12:56 tiwai          Note Added: 0001206                          
06-05-04 12:22 martin         Note Added: 0001292                          
01-13-05 17:32 tiwai          Status                   new => resolved     
01-13-05 17:32 tiwai          Resolution               open => fixed       
01-13-05 17:32 tiwai          Assigned To               => tiwai           
01-13-05 17:32 tiwai          Note Added: 0003196                          
======================================================================




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
