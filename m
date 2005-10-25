From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001482]: Front channels distorsions in Phase 28
Date: Tue, 25 Oct 2005 20:05:05 +0200
Message-ID: <931981136bf2f8679a58804f0813f6dd@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 51559188
	for <alsa-devel@alsa-project.org>; Tue, 25 Oct 2005 20:05:06 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1482> 
======================================================================
Reported By:                eric
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1482
Category:                   PCI - ice1724
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             2.6.8.1 Custom epia
======================================================================
Date Submitted:             10-18-2005 11:45 CEST
Last Modified:              10-25-2005 20:05 CEST
======================================================================
Summary:                    Front channels distorsions in Phase 28
Description: 
Hello , i have problems on Terratec Phase 28 :

front channels distortions, other no problems (rear , center , side ...)

you can view for sample screenshots of 1000Hz signal applied of front and
rear channels

I use last alsa drivers 1.0.9b and last library on Debian sarge 3.1

thanks 
======================================================================

----------------------------------------------------------------------
 eric - 10-25-05 20:05 
----------------------------------------------------------------------
Hi , with last alsa cvs , same problem.

i don't understand why six channels works perfectly and two have strange 
distortion.

thanks

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-18-05 11:45 eric           New Issue                                    
10-18-05 11:45 eric           File Added: screenshot.zip                    
10-18-05 11:45 eric           Kernel Version            => 2.6.8.1 Custom epia
10-25-05 20:05 eric           Note Added: 0006550                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
