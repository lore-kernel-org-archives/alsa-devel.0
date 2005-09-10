From: bugtrack@alsa-project.org
Subject: [ALSA - plugins 0001411]: plug:jack interface not working for apps that both read and write
Date: Sat, 10 Sep 2005 17:57:25 +0200
Message-ID: <2e046f6924c726d537addcab00dfa0a7@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id DAC5B15D
	for <alsa-devel@alsa-project.org>; Sat, 10 Sep 2005 17:57:25 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1411> 
======================================================================
Reported By:                b0ef
Assigned To:                
======================================================================
Project:                    ALSA - plugins
Issue ID:                   1411
Category:                   PCM - jack
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             09-10-2005 17:57 CEST
Last Modified:              09-10-2005 17:57 CEST
======================================================================
Summary:                    plug:jack interface not working for apps that both
read and write
Description: 
This is a general problem with any app that both read and write to the
plug:jack device. It (plug:jack) however works for apps that only do one
or the other. 
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-10-05 17:57 b0ef           New Issue                                    
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
