From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ALSA: ASoC: Fix SmartQ compilation
Date: Wed, 5 Jan 2011 10:04:10 +0000
Message-ID: <20110105100409.GA6262@sirena.org.uk>
References: <4d20d689.cc7e0e0a.6f59.4a1d@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 3C36110386B
	for <alsa-devel@alsa-project.org>; Wed,  5 Jan 2011 11:04:13 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4d20d689.cc7e0e0a.6f59.4a1d@mx.google.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Maurus Cuelenaere <mcuelenaere@gmail.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, jassi.brar@samsung.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Sun, Jan 02, 2011 at 08:48:23PM +0100, Maurus Cuelenaere wrote:
> This makes the SmartQ sound driver compile again with recent ASoC changes.
> 
> Signed-off-by: Maurus Cuelenaere <mcuelenaere@gmail.com>

As Jassi said this doesn't apply against -next.  I've applied for 2.6.37
and done a merge but I may have resolved some stuff incorrectly so
please check.
