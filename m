From: Peter Stokes <linux@dadeos.co.uk>
Subject: [PATCH 0/2] New Control Plugin - arcam-av
Date: Sat, 3 Jan 2009 20:56:25 +0000
Message-ID: <200901032056.25598.linux@dadeos.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp6.freeserve.com (unknown [193.252.22.191])
	by alsa0.perex.cz (Postfix) with ESMTP id EA4231037E3
	for <alsa-devel@alsa-project.org>; Sat,  3 Jan 2009 21:56:37 +0100 (CET)
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf3606.me.freeserve.com (SMTP Server) with ESMTP id 4E9D47000084
	for <alsa-devel@alsa-project.org>; Sat,  3 Jan 2009 21:56:37 +0100 (CET)
Received: from RedDwarf.dadeos.co.uk (unknown [91.111.88.68])
	by mwinf3606.me.freeserve.com (SMTP Server) with ESMTP id 21E607000083
	for <alsa-devel@alsa-project.org>; Sat,  3 Jan 2009 21:56:37 +0100 (CET)
Received: from tuscan.dadeos.co.uk (tuscan.dadeos.co.uk [10.0.1.252])
	by RedDwarf.dadeos.co.uk (8.14.3/8.14.2) with ESMTP id n03KuPmt031800
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <alsa-devel@alsa-project.org>; Sat, 3 Jan 2009 20:56:26 GMT
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

I have developed a new ALSA control plugin that I would like to be considered 
for inclusion into the alsa-plugins package.

The plugin is for exposing the controls of an Arcam AV amplifier attached to a 
PC via an RS-232 null-modem cable.

These patches are against the release source for alsa-plugins-1.0.18.

Best regards

Peter Stokes
