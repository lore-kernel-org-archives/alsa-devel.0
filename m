From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000131]: Sound is very bad in kernel 2.6.* with Intel 82801CA/CAM AC'97 Audio
Date: Sat, 31 Dec 2005 04:10:20 +0100
Message-ID: <b00670a9a66147ae703f63c89a344a79@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 6AB76167
	for <alsa-devel@alsa-project.org>; Sat, 31 Dec 2005 04:10:20 +0100 (MET)
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


The following issue has been CLOSED
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=131> 
======================================================================
Reported By:                Ahmad
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   131
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     closed
Distribution:               Gentoo
Kernel Version:             2.6.3
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             03-13-2004 19:42 CET
Last Modified:              12-31-2005 04:10 CET
======================================================================
Summary:                    Sound is very bad in kernel 2.6.* with Intel
82801CA/CAM AC'97 Audio
Description: 
Using Alsa in kernel 2.6.* with Intel 82801CA/CAM AC'97 Audio gives me very
bad sound and produce many many errors in /var/log/messages

======================================================================

----------------------------------------------------------------------
 jdthood - 04-01-05 22:55 
----------------------------------------------------------------------
Submitter: Did you see any improvement with "acpi=off"?  Does the problem
still exist in later versions of the ALSA driver?

----------------------------------------------------------------------
 rlrevell - 12-31-05 04:10 
----------------------------------------------------------------------
No response

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-13-04 19:42 Ahmad          New Issue                                    
03-13-04 19:42 Ahmad          Distribution              => Gentoo          
03-13-04 19:42 Ahmad          Kernel Version            => 2.6.3           
03-14-04 19:45 perex          Note Added: 0000602                          
03-14-04 19:45 perex          Category                 CORE - pcm => PCI -
intel8x0
03-15-04 05:07 Ahmad          Note Added: 0000607                          
03-15-04 12:11 perex          Note Added: 0000608                          
04-20-04 20:07 ilia           Issue Monitored: ilia                        
04-20-04 20:11 ilia           Note Added: 0000889                          
04-20-04 20:13 ilia           Note Edited: 0000889                         
04-20-04 20:33 ilia           Note Deleted: 0000889                        
04-26-04 22:24 segoh          Issue Monitored: segoh                       
04-01-05 22:55 jdthood        Note Added: 0004295                          
12-31-05 04:10 rlrevell       Status                   new => closed       
12-31-05 04:10 rlrevell       Note Added: 0007341                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
