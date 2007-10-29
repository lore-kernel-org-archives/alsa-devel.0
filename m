From: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
Subject: Re: Sample format coversion bug?
Date: Mon, 29 Oct 2007 16:21:21 +0500
Message-ID: <4725C231.8030805@ums.usu.ru>
References: <4721E932.5090603@ums.usu.ru>	<s5hpryyny19.wl%tiwai@suse.de>	<4725BD78.6040709@ums.usu.ru>
	<s5hk5p6nveb.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relay4.usu.ru (relay4.usu.ru [194.226.235.39])
	by alsa0.perex.cz (Postfix) with ESMTP id 75788243C0
	for <alsa-devel@alsa-project.org>; Mon, 29 Oct 2007 12:21:19 +0100 (CET)
Received: from relay4.usu.ru (localhost [127.0.0.1])
	by relay4.usu.ru (PostSystem) with ESMTP id A1C98180A9
	for <alsa-devel@alsa-project.org>;
	Mon, 29 Oct 2007 16:24:00 +0500 (YEKT)
Received: from usu2.usu.ru (usu2.usu.ru [194.226.237.16])
	by relay4.usu.ru (PostSystem) with ESMTP id E65B5180A9
	for <alsa-devel@alsa-project.org>;
	Mon, 29 Oct 2007 16:23:58 +0500 (YEKT)
Received: from usu2.usu.ru (localhost.usu2.usu.ru [127.0.0.1])
	by usu2.usu.ru (Postfix) with ESMTP id B13A0A7EB0
	for <alsa-devel@alsa-project.org>;
	Mon, 29 Oct 2007 16:21:16 +0500 (YEKT)
Received: from ums.usu.ru (ums.usu.ru [194.226.236.116])
	by usu2.usu.ru (Postfix) with ESMTP id 89147A7E95
	for <alsa-devel@alsa-project.org>;
	Mon, 29 Oct 2007 16:21:16 +0500 (YEKT)
In-Reply-To: <s5hk5p6nveb.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> The latter case.  Does your driver support mmap?
>   

Unfortunately, I am at work now, writing from Windows, and cannot check 
for sure. The driver name is "saa7134-alsa", and, according to 
http://linuxtv.org/hg/v4l-dvb/file/6b1892ed1e74/linux/drivers/media/video/saa7134/saa7134-alsa.c, 
it does support mmap.

-- 

Alexander E. Patrakov
