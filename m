From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH] ASoC: count reaches 10001, not 10000.
Date: Sun, 8 Feb 2009 20:36:52 +0000
Message-ID: <20090208203652.GB16002@sirena.org.uk>
References: <498F13B1.1090704@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id C6CEB2435D
	for <alsa-devel@alsa-project.org>; Sun,  8 Feb 2009 21:37:00 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <498F13B1.1090704@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Roel Kluin <roel.kluin@gmail.com>
Cc: uclinux-dist-devel@blackfin.uclinux.org, cooloney@kernel.org, alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Sun, Feb 08, 2009 at 06:17:37PM +0100, Roel Kluin wrote:
> With a postfix increment count reaches 10001, not 10000.

Applied since it's very small but please try to remember to provide a
signed-off-by for your commits.
