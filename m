From: Daniel Chen <seven.steps@gmail.com>
Subject: Re: VGN-P11Z_G (hda-intel ALC262) internal microphone
	not working
Date: Sat, 9 Jan 2010 16:58:33 -0500
Message-ID: <604760771001091358r64d510f1k27d418142a3f0445@mail.gmail.com>
References: <7c16f72a1001071534sd8992e9je69bab0271b491b5@mail.gmail.com>
	<604760771001071627x33c93eeemd386e026e0c8f032@mail.gmail.com>
	<7c16f72a1001091334y67c847b7oaeed99cd97735100@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f53.google.com (mail-pw0-f53.google.com
	[209.85.160.53])
	by alsa0.perex.cz (Postfix) with ESMTP id ED6E31037F2
	for <alsa-devel@alsa-project.org>; Sat,  9 Jan 2010 22:58:34 +0100 (CET)
Received: by pwi18 with SMTP id 18so2685657pwi.32
	for <alsa-devel@alsa-project.org>; Sat, 09 Jan 2010 13:58:33 -0800 (PST)
In-Reply-To: <7c16f72a1001091334y67c847b7oaeed99cd97735100@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: =?UTF-8?Q?Christian_St=C3=B6veken?= <christian.stoeveken@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This isn't using model=auto, as you can clearly see from the alsa-info output:

model : vaio,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>
