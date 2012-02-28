From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] ASoC: omap3beagle: Add dai link for McBSP2
 master configuration (CLKS source)
Date: Tue, 28 Feb 2012 11:11:09 +0200
Message-ID: <4F4C9A2D.1010807@ti.com>
References: <1330415714-5136-1-git-send-email-peter.ujfalusi@ti.com>
	<4F4C920A.4090606@bitmer.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog101.obsmtp.com (na3sys009aog101.obsmtp.com
	[74.125.149.67]) by alsa0.perex.cz (Postfix) with ESMTP id 31012245A3
	for <alsa-devel@alsa-project.org>; Tue, 28 Feb 2012 10:11:26 +0100 (CET)
Received: by mail-lpp01m010-f50.google.com with SMTP id m13so5258797lah.9
	for <alsa-devel@alsa-project.org>; Tue, 28 Feb 2012 01:11:12 -0800 (PST)
In-Reply-To: <4F4C920A.4090606@bitmer.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jarkko.nikula@bitmer.com>
Cc: Steve Sakoman <steve@sakoman.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Grazvydas Ignotas <notasas@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 02/28/2012 10:36 AM, Jarkko Nikula wrote:
> Is this something that is better to stay in list archives not under
> version control? This looks to me as a developer debug feature.

Good question...
Right now I'm not sure if this patch has practical use at the moment.
It does not hurt to be in the tree since the default PCM does not
change. But it might confuse users.
Either way is good for me.

-- =

P=E9ter
