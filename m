From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: Re: [PATCH] ASoC: intel: remove unused variable
Date: Tue, 1 Mar 2016 11:19:27 +0530
Message-ID: <20160301054858.GA3814@sudip-pc>
References: <1456766626-20807-1-git-send-email-sudipm.mukherjee@gmail.com>
 <20160301025912.GF18327@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160301025912.GF18327@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Mar 01, 2016 at 11:59:12AM +0900, Mark Brown wrote:
> On Mon, Feb 29, 2016 at 10:53:46PM +0530, Sudip Mukherjee wrote:
> > The variable cmd_id is only assigned some value and is never used.
> > 
> > Signed-off-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
> 
> Your signoff doesn't correspond to your e-mail address.  While I'm
> fairly sure that you are in fact the same person so it's OK this time
> please try to ensure that they match up so that it's clear that the
> signoffs are all in order.

But it has been like this way since I started contributing.
git log --author=sudip will show you.

From: address was always sudipm.mukherjee@gmail.com
but Signed-off-by: was sudip@vectorindia.org and now
Signed-off-by: has changed to sudip.mukherjee@codethink.co.uk
and you already have many such patches from me. (well, with my
vectorindia.org email)

Can i not keep using my gmail as my From: ?
The advantage of using gmail as my From: is that the discussion and all
threads related to my patches will be in the same place even if my work
email is changed.

And AFAIK, the From: name and the Signed-off-by: name should match else
the tools used by Greg and others to generate the stats will break.

Please reconsider and let me use my gmail in my From:

regards
sudip
