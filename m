From: bugtrack@alsa-project.org
Subject: [ALSA - tools 0002136]: ice1724gt support for
	Envy24Control
Date: Sat, 22 Jul 2006 02:58:38 +0200
Message-ID: <7ac111e298f5ddce754c91c0da203ef4@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 3C474174
	for <alsa-devel@alsa-project.org>;
	Sat, 22 Jul 2006 02:58:38 +0200 (MEST)
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


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2136> 
======================================================================
Reported By:                hlabs
Assigned To:                
======================================================================
Project:                    ALSA - tools
Issue ID:                   2136
Category:                   envy24control
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             05-19-2006 21:21 CEST
Last Modified:              07-22-2006 02:58 CEST
======================================================================
Summary:                    ice1724gt support for Envy24Control
Description: 
What about ice1724gt support for Envy24Control util ?
My card is M-Audio Revolution 5.1
Envy24Control says : no Ice1712 found.

All modules loads fine but no sound at all :(
Vanilla kernel 2.6.16 with ALSA 1.0.11 .
Trial OSS works fine .

======================================================================

----------------------------------------------------------------------
 hlabs - 05-24-06 15:09 
----------------------------------------------------------------------
After some tweaks in .asoundrc file i got front out working but not
others.
I think this is ice1724 driver issue...

----------------------------------------------------------------------
 cruiseoveride - 07-22-06 02:58 
----------------------------------------------------------------------
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1831

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-19-06 21:21 hlabs          New Issue                                    
05-19-06 21:22 hlabs          Issue Monitored: hlabs                       
05-19-06 23:55 gineera        Note Added: 0009880                          
05-19-06 23:56 gineera        Note Edited: 0009880                         
05-20-06 00:00 rlrevell       Note Added: 0009881                          
05-20-06 18:55 hlabs          Note Added: 0009890                          
05-24-06 15:09 hlabs          Note Added: 0009957                          
06-08-06 16:48 drycellbattery Issue Monitored: drycellbattery                   

07-22-06 02:58 cruiseoveride  Note Added: 0011160                          
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
