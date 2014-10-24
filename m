From: Jonathan Bennett <jbscience87@gmail.com>
Subject: Re: Request for comments for SND_SOC_IMX_WM8731
Date: Fri, 24 Oct 2014 11:33:51 -0500
Message-ID: <CAB-pspeqQ=1sSWYQVVBdv8AitPfYby-HFEnHseLCAk_XzBAqrQ@mail.gmail.com>
References: <CAB-pspcgsa3-YgBfk-5TUoyfEN0pbBHtqCUrzyaQdCA-QNHt1Q@mail.gmail.com>
 <CAOMZO5AXhj-r4v-sR6Rp_ywD85M07W06r551vMq0r6juE+Tmgg@mail.gmail.com>
 <20141024140440.GG3729@sirena.org.uk>
 <CAOMZO5AJ=KehtXWvh10LTCV25gWGn2DgSLprm8bG3trVcsxHrg@mail.gmail.com>
 <CAB-pspe+NP-bvBF=wm-3EQjMw7mvzSeAEH1O-j_fen=L50mkNw@mail.gmail.com>
 <20141024161902.GI3729@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ig0-f172.google.com (mail-ig0-f172.google.com
 [209.85.213.172])
 by alsa0.perex.cz (Postfix) with ESMTP id 5C1D72604B1
 for <alsa-devel@alsa-project.org>; Fri, 24 Oct 2014 18:33:53 +0200 (CEST)
Received: by mail-ig0-f172.google.com with SMTP id r2so684529igi.5
 for <alsa-devel@alsa-project.org>; Fri, 24 Oct 2014 09:33:52 -0700 (PDT)
In-Reply-To: <20141024161902.GI3729@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, Nicolin Chen <nicoleotsuka@gmail.com>, Aaron Kling <webgeek1234@gmail.com>, Igor Grinberg <grinberg@compulab.co.il>, Valentin Raevsky <valentin@compulab.co.il>, Fabio Estevam <festevam@gmail.com>
List-Id: alsa-devel@alsa-project.org

When I sent the original rfc message to the mailing list, it was denied for
being over 60k, hence my question. Looking at the raw email, I suspect that
gmail is inflating the size dramatically by sending both plaintext and html
versions.

The document, SubmittingPatches, also refers to the large patch issue. On
re-reading it, I see it puts the limit at 300k, which this is nowhere near.
I'll see about using git send-email for the next attempt at sending it in.
On Oct 24, 2014 11:19 AM, "Mark Brown" <broonie@kernel.org> wrote:

> On Fri, Oct 24, 2014 at 09:48:37AM -0500, Jonathan Bennett wrote:
>
> > Oh, also, this patch is a bit big for the mailing list, what is the
> > preferred method for sending in large patches to look at? I can attach,
> > throw it on github, put it on an http server, etc.
>
> You need to follow the procedure in SubmittingPatches, that means you
> need to post your code to the list.
>
