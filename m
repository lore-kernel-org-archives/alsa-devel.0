From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001552]: Fails to read config file when locale numerical delimiter is not '.'
Date: Mon, 14 Nov 2005 11:03:37 +0100
Message-ID: <47eac9e1011e9d519b54d3a1cf548355@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 543AA19E
	for <alsa-devel@alsa-project.org>; Mon, 14 Nov 2005 11:03:37 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1552> 
======================================================================
Reported By:                gena2x
Assigned To:                perex
======================================================================
Project:                    ALSA - lib
Issue ID:                   1552
Category:                   0_general
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     resolved
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             11-13-2005 20:12 CET
Last Modified:              11-14-2005 11:03 CET
======================================================================
Summary:                    Fails to read config file when locale numerical
delimiter is not '.'
Description: 
Real values can not be read in any way from conffile while locale 
numerical delimiter is not '.'
======================================================================

----------------------------------------------------------------------
 perex - 11-14-05 11:03 
----------------------------------------------------------------------
Already fixed in ALSA's CVS.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-13-05 20:12 gena2x         New Issue                                    
11-14-05 11:03 perex          Status                   new => resolved     
11-14-05 11:03 perex          Resolution               open => fixed       
11-14-05 11:03 perex          Assigned To               => perex           
11-14-05 11:03 perex          Note Added: 0006714                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
