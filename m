From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 2/2] sound/soc/soc-core.c: cleanup
	kernel-doc
Date: Tue, 25 Nov 2008 15:53:57 +0000
Message-ID: <20081125155357.GJ12414@sirena.org.uk>
References: <492c18cb.0c636e0a.1c1a.ffffb2b3@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 72C8E24487
	for <alsa-devel@alsa-project.org>; Tue, 25 Nov 2008 16:54:00 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <492c18cb.0c636e0a.1c1a.ffffb2b3@mx.google.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Qinghuang Feng <qhfeng.kernel@gmail.com>
Cc: Randy Dunlap <rdunlap@xenotime.net>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 25, 2008 at 11:24:54PM +0800, Qinghuang Feng wrote:
> There is no argument named @clk_id in snd_soc_dai_set_fmt,
> remove its' comment.

> Signed-off-by: Qinghuang Feng <qhfeng.kernel@gmail.com>

Applied, thanks.

Please make sure to CC relevant maintainers on patches (even for generic
ALSA you've missed off Takashi Iwai here).  It helps make sure patches
don't get missed.
