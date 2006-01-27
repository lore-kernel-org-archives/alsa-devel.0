From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001788]: dmix is not enabled for usb headset, only single application can make audio
Date: Fri, 27 Jan 2006 22:27:38 +0100
Message-ID: <20060127212738.55C581B6@alsa.jcu.cz>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 55C581B6
	for <alsa-devel@alsa-project.org>; Fri, 27 Jan 2006 22:27:38 +0100 (MET)
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

output at the same time
Message-ID: <bdef3e094bee993514d366f733963904@bugtrack.alsa-project.org>
X-Priority: 3
X-Mailer: PHPMailer [version 1.72]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="iso-8859-1"


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1788> 
======================================================================
Reported By:                tvignaud
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - driver
Issue ID:                   1788
Category:                   USB - usb-audio
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               Mandriva
Kernel Version:             2.6.12
======================================================================
Date Submitted:             01-27-2006 22:27 CET
Last Modified:              01-27-2006 22:27 CET
======================================================================
Summary:                    dmix is not enabled for usb headset, only single
application can make audio
output at the same time
Description: 
users are complaining that dmix is not enabled for usb headset (tested with
a C-Media USB Headphone Set), and so that only single application can make
audio output at the same time.

can anything be done in alsa-lib?
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-27-06 22:27 tvignaud       New Issue                                    
01-27-06 22:27 tvignaud       Distribution              => Mandriva        
01-27-06 22:27 tvignaud       Kernel Version            => 2.6.12          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
