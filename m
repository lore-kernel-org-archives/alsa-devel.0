From: "Sebastian H." <vand2@gmx.de>
Subject: Mixer volume/decibel mapping
Date: Wed, 19 May 2010 18:34:57 +0200
Message-ID: <201005191834.57919.vand2@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa0.perex.cz (Postfix) with SMTP id 71F5410396E
	for <alsa-devel@alsa-project.org>;
	Wed, 19 May 2010 18:35:22 +0200 (CEST)
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


Hello everyone

I'm working on an ALSA-Mixer application for C++/Qt4 and stumbled over
volume and decibel mapping for sliders.
My question: Is there always an 1 to 1 mapping from volume to decibel and vice 
versa or can there be decibel values in between two volume steps?

Regards,
Sebastian H.
