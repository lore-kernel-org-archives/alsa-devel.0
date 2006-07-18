From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000441]: Master volume not doing
	anything
Date: Tue, 18 Jul 2006 14:41:59 +0200
Message-ID: <415dec0ff4afd01e5b34321517b1b879@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 027C6176
	for <alsa-devel@alsa-project.org>;
	Tue, 18 Jul 2006 14:41:59 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


The following issue has been ASSIGNED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=441> 
======================================================================
Reported By:                Simon
Assigned To:                jcdutton
======================================================================
Project:                    ALSA - driver
Issue ID:                   441
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     assigned
Distribution:               Slackware
Kernel Version:             2.
======================================================================
Date Submitted:             08-14-2004 20:49 CEST
Last Modified:              07-18-2006 14:41 CEST
======================================================================
Summary:                    Master volume not doing anything
Description: 
I have sound, everything works, but the master volume control doesn't have
any effect on the actual volume output.

Running Soundblaster Live! 5.1 dolby surround system
======================================================================

----------------------------------------------------------------------
 jdthood - 07-16-05 17:14 
----------------------------------------------------------------------
Submitter: Is there any improvement in more recent ALSA releases?

----------------------------------------------------------------------
 Simon - 07-16-05 21:20 
----------------------------------------------------------------------
It works now for only the subwoofer and the left front and rear... it's an
improvement

Current kernel version running:
2.6.8-24.16 or 2.6.11.9

Latest ALSA driver



----------------------------------------------------------------------
 rlrevell - 12-31-05 04:05 
----------------------------------------------------------------------
Do you consider the bug fixed?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-14-04 20:49 Simon          New Issue                                    
08-14-04 20:49 Simon          Distribution              => Slackware       
08-14-04 20:49 Simon          Kernel Version            => 2.              
07-16-05 17:14 jdthood        Note Added: 0005499                          
07-16-05 21:19 Simon          Note Added: 0005502                          
07-16-05 21:20 Simon          Note Edited: 0005502                         
08-03-05 12:24 perex          Category                 CORE - control => PCI -
emu10k1
12-31-05 04:05 rlrevell       Note Added: 0007336                          
07-18-06 14:41 jcdutton       Status                   new => assigned     
07-18-06 14:41 jcdutton       Assigned To               => jcdutton        
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
