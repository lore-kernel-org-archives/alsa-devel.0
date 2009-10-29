From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH] ASoC: TWL4030: Add APLL supply for the
	capture path
Date: Thu, 29 Oct 2009 13:17:42 +0200
Message-ID: <200910291317.42443.peter.ujfalusi@nokia.com>
References: <1256814352-22408-1-git-send-email-peter.ujfalusi@nokia.com>
	<20091029111140.GA10275@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id DC6992468E
	for <alsa-devel@alsa-project.org>; Thu, 29 Oct 2009 12:17:55 +0100 (CET)
In-Reply-To: <20091029111140.GA10275@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thursday 29 October 2009 13:11:40 ext Mark Brown wrote:
> On Thu, Oct 29, 2009 at 01:05:52PM +0200, Peter Ujfalusi wrote:
> > Capture path also need the APLL enabled, adding DAPM_SUPPLY
> > for the Virtual ADCs.
> >
> > Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
> =

> I've queued this one up too.

Thanks, and again: sorry about it, this should have been part of the first =

patch.

-- =

P=E9ter
