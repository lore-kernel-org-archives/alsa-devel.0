From: Daniel Chen <seven.steps@gmail.com>
Subject: Re: ALSA: HDA VIA VT2020 support
Date: Mon, 28 Dec 2009 05:33:06 -0500
Message-ID: <604760770912280233h183c13fdv8159f95246c86f33@mail.gmail.com>
References: <4B379281.7040401@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f53.google.com (mail-pw0-f53.google.com
	[209.85.160.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 7B0B1103810
	for <alsa-devel@alsa-project.org>; Mon, 28 Dec 2009 11:33:08 +0100 (CET)
Received: by pwi18 with SMTP id 18so25768221pwi.32
	for <alsa-devel@alsa-project.org>; Mon, 28 Dec 2009 02:33:06 -0800 (PST)
In-Reply-To: <4B379281.7040401@free.fr>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: draco <draco31.fr@free.fr>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sun, Dec 27, 2009 at 11:59 AM, draco <draco31.fr@free.fr> wrote:
> Unfortunately, despite all was OK from the 1.0.21+git devel snapshot few
> month ago, the alsa-driver v1.0.22 doesn't work.
> I tried different snapshot from 1.0.22, and sent a bug report here :
> https://bugtrack.alsa-project.org/alsa-bug/view.php?id=4857

See:
http://git.kernel.org/?p=linux/kernel/git/tiwai/sound-2.6.git;a=commit;h=21949f00a022e090a7e8bc9a01dfca88273c6146

It may be a good idea to roll an alsa-driver 1.0.22.1.

-Dan
