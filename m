From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/1] Do not write to invalid registers on
 the wm9712.
Date: Wed, 23 Dec 2009 15:23:19 +0000
Message-ID: <20091223152319.GA2474@opensource.wolfsonmicro.com>
References: <1261502938-11137-1-git-send-email-emillbrandt@dekaresearch.com>
	<20091222234628.GB2643@sirena.org.uk>
	<0A40042D85E7C84DB443060EC44B3FD308C08371C3@dekaexchange07.deka.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <0A40042D85E7C84DB443060EC44B3FD308C08371C3@dekaexchange07.deka.local>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Eric Millbrandt <emillbrandt@dekaresearch.com>
Cc: "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "patch@alsa-project.org" <patch@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Dec 23, 2009 at 10:00:37AM -0500, Eric Millbrandt wrote:

> It looks like the legal jargon post-pended to the patch creates grief for
> git.  I am resubmitting the patch as an attachment so that is will not get
> mangled.

Applied, thanks.  The signature won't have done anything to affect the
patch - the unified diff format can handle comments and other descriptive
text interspersed with the code without problems.
