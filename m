From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0002182]: multi plugin generates null
	output --> no sound
Date: Fri, 2 Jun 2006 20:48:55 +0200
Message-ID: <ae81ee7de9d709698f79ba3421230cf0@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 832B215A
	for <alsa-devel@alsa-project.org>;
	Fri,  2 Jun 2006 20:48:55 +0200 (MEST)
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


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2182> 
======================================================================
Reported By:                fchevalier
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   2182
Category:                   1_pcm - digital audio
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             06-02-2006 20:48 CEST
Last Modified:              06-02-2006 20:48 CEST
======================================================================
Summary:                    multi plugin generates null output --> no sound
Description: 
Under some circumstances, no sound is copied from multi plugin to its slave
plugins. Issue seems somewhat related to userspace I/O plugins.
Result is no sound at all.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-02-06 20:48 fchevalier     New Issue                                    
======================================================================
