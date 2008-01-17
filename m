From: "Claudio Matsuoka" <cmatsuoka@gmail.com>
Subject: Re: HDA codec graphing
Date: Thu, 17 Jan 2008 16:18:52 -0200
Message-ID: <5f52f6d70801171018g334caca6k6d7bd49b9b1ef2@mail.gmail.com>
References: <5f52f6d70801170424o4682381fhc12416125a1b66a8@mail.gmail.com>
	<s5hwsq8ecgt.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.237])
	by alsa0.perex.cz (Postfix) with ESMTP id C48EC245AA
	for <alsa-devel@alsa-project.org>; Thu, 17 Jan 2008 19:19:00 +0100 (CET)
Received: by nz-out-0506.google.com with SMTP id m22so526861nzf.2
	for <alsa-devel@alsa-project.org>; Thu, 17 Jan 2008 10:18:53 -0800 (PST)
In-Reply-To: <s5hwsq8ecgt.wl%tiwai@suse.de>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA Developers <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Jan 17, 2008 12:46 PM, Takashi Iwai <tiwai@suse.de> wrote:

> Nice.  Then we shouldn't change the proc output format any more, or at
> least, keep codecgraph working :)

Change the format as needed, as long as it is unambiguous and contains
all the necessary information we'll keep the tool up to date.


> I think it's worth to include this to the ALSA upstream repo.
> Any other useful stuff?  Maybe Tobin's script would be good.
> Or, maybe it's better to keep outside so that other people can change
> more freely than on alsa-project.org...

The grapher is still unstable, keeping it outside would probably be
better for now.
