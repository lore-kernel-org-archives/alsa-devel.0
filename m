From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH V2 4/9] Add a few more mpc5200 PSC defines
Date: Sun, 24 May 2009 12:19:37 -0600
Message-ID: <fa686aa40905241119t5e85311cj8a181c11b3890f0b@mail.gmail.com>
References: <20090523231148.17919.46103.stgit@terra>
	<20090523231303.17919.35877.stgit@terra>
	<fa686aa40905240713g2e79367mec0ba185432a94a@mail.gmail.com>
	<20090524180023.GA4525@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yw-out-1718.google.com (yw-out-1718.google.com [74.125.46.154])
	by alsa0.perex.cz (Postfix) with ESMTP id 16CD124537
	for <alsa-devel@alsa-project.org>;
	Sun, 24 May 2009 20:19:57 +0200 (CEST)
Received: by yw-out-1718.google.com with SMTP id 4so2086134ywq.2
	for <alsa-devel@alsa-project.org>; Sun, 24 May 2009 11:19:57 -0700 (PDT)
In-Reply-To: <20090524180023.GA4525@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sun, May 24, 2009 at 12:00 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Sun, May 24, 2009 at 08:13:19AM -0600, Grant Likely wrote:
>> On Sat, May 23, 2009 at 5:13 PM, Jon Smirl <jonsmirl@gmail.com> wrote:
>> > Add a few more mpc5200 PSC defines. More bit fields defines for mpc5200 PSC registers. This patch is going in via Grant's tree.
>
>> > Signed-off-by: Jon Smirl <jonsmirl@gmail.com>
>
>> Acked-by: Grant Likely <grant.likely@secretlab.ca>
>
> Jon's commit log says this is going in via your tree - is that the case
> or should I apply it to ASoC?

Nothing else needs it in MPC5200 land and I haven't applied it to my
tree yet.  Go ahead and add it to the ASoC tree.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
