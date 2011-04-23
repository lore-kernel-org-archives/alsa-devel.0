From: Daniel Mack <zonque@gmail.com>
Subject: Re: Alsa Support for Korg Pandora Mini, Vox ToneLab ST
Date: Sat, 23 Apr 2011 10:52:11 +0200
Message-ID: <BANLkTi=VzbXkTQmtD-Py2UO4+PqQXorofQ@mail.gmail.com>
References: <BANLkTikGDzzhXQLTpsHvqqJ=b30JgkumJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vx0-f179.google.com (mail-vx0-f179.google.com
	[209.85.220.179])
	by alsa0.perex.cz (Postfix) with ESMTP id B3DAB1037F9
	for <alsa-devel@alsa-project.org>;
	Sat, 23 Apr 2011 10:52:12 +0200 (CEST)
Received: by vxi40 with SMTP id 40so1046410vxi.38
	for <alsa-devel@alsa-project.org>; Sat, 23 Apr 2011 01:52:11 -0700 (PDT)
In-Reply-To: <BANLkTikGDzzhXQLTpsHvqqJ=b30JgkumJQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Pawel Siemienski <pawel.siemienski@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Apr 19, 2011 at 9:39 AM, Pawel Siemienski
<pawel.siemienski@gmail.com> wrote:
> Hi,
>
> I am Ubuntu Studio user and I use also ALSA for driving my audio for
> recording etc...
> I have tested two devices with ALSA:
> 1. Vox Tonelab ST - works with ALSA out of the box as USB audio interface
> with no need of modifications, provides complete functionalities needed for
> recording and playing audio
> 2. Korg Pandora Mini - is detected as audio interface, but when selecting it
> information that no controls are available is displayed, this device can not
> work as audio interface in fact with Alsa.
>
> Could you please advise what modifications in ALSA should be made to enable
> Korg Pandora Mini as audio interface with ALSA, is there any patch for this
> device?
> If you would need any information on Korg Pandora Mini please let know.

Can you send a full "lsusb -v" output, please?

Daniel
