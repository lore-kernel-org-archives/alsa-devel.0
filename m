From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0001505]: rcalsasound script does not exists in some distros
Date: Wed, 26 Oct 2005 16:07:11 +0200
Message-ID: <d16f5f095f8f06fded9530554466e750@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 81395185
	for <alsa-devel@alsa-project.org>; Wed, 26 Oct 2005 16:07:11 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1505> 
======================================================================
Reported By:                Davide Madrisan
Assigned To:                
======================================================================
Project:                    ALSA - utils
Issue ID:                   1505
Category:                   alsaconf
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             10-26-2005 16:07 CEST
Last Modified:              10-26-2005 16:07 CEST
======================================================================
Summary:                    rcalsasound script does not exists in some distros
Description: 
The alsaconf script try to execute $rcalsasound with default value
"rcalsasound".
For some distros (QiLinux for instance) the default value is used but no
rcalsasound binary is present, so an error is displayed.

======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-26-05 16:07 Davide MadrisanNew Issue                                    
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
