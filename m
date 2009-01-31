From: Vivia Nikolaidou <vivia@ee.auth.gr>
Subject: snd-hda-intel option for Toshiba A200-1MB
Date: Sat, 31 Jan 2009 19:47:40 +0200 (EET)
Message-ID: <alpine.DEB.2.00.0901311947200.24384@ourania.autom.teithe.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ourania.autom.teithe.gr (ourania.autom.teithe.gr
	[195.251.122.10])
	by alsa0.perex.cz (Postfix) with ESMTP id 97E6F243D9
	for <alsa-devel@alsa-project.org>; Sat, 31 Jan 2009 18:47:40 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by ourania.autom.teithe.gr (Postfix) with ESMTPS id 2EBC045C279
	for <alsa-devel@alsa-project.org>; Sat, 31 Jan 2009 19:47:40 +0200 (EET)
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


Dear ALSA developers,

I recently installed linux on a Toshiba Satellite A200-1MB laptop. Its sound 
card is ALC861VD, using the hda_intel module. The problem was that the earphone 
jack sense wasn't working. It turns out that I had to use the Lenovo option. It 
would be nice if you could add this model (and probably other A200 models as 
well) to ALSA-Configuration.txt .

Thank you,

Vivia Nikolaidou
