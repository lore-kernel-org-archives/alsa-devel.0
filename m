From: Antonio Ospite <ao2@ao2.it>
Subject: Re: [PATCH 05/12] trivial: ASoC: adau1977: fix typo
 s/Substraction/Subtraction/
Date: Tue, 28 Apr 2015 23:27:58 +0200
Message-ID: <20150428232758.28e194be2c9a3d61be23f4bc@ao2.it>
References: <1430219491-5076-1-git-send-email-ao2@ao2.it>
 <1430219491-5076-6-git-send-email-ao2@ao2.it>
 <20150428160023.GW22845@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp206.alice.it (smtp206.alice.it [82.57.200.102])
 by alsa0.perex.cz (Postfix) with ESMTP id 78CCD260422
 for <alsa-devel@alsa-project.org>; Tue, 28 Apr 2015 23:28:09 +0200 (CEST)
In-Reply-To: <20150428160023.GW22845@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Jiri Kosina <trivial@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Tue, 28 Apr 2015 17:00:24 +0100
Mark Brown <broonie@kernel.org> wrote:

> On Tue, Apr 28, 2015 at 01:11:24PM +0200, Antonio Ospite wrote:
> > Signed-off-by: Antonio Ospite <ao2@ao2.it>
> 
> Applied, but please use subject lines reflecting the style for the
> subsystem and don't send only a single patch for a series.

Hi Mark,

I tried to follow the subject style for the subsystem, but then I
prefixed it with "trivial" to highlight that I was sending an aggregate
set of unrelated patches to trivial@kernel.org, that's also why I didn't
want to CC everyone on every patch: to reduce noise.

Maybe involving trivial@kernel.org for changes which apply to a
_specific_ subsystem is not necessary at all, next time I will just
aggregate by subsystem.

As a rule of thumb I will use trivial@kernel.org only for trivial
changes which span different subsystems and still make sense to have in
a single patch.

Thanks for making me notice that.

Ciao,
   Antonio

-- 
Antonio Ospite
http://ao2.it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
