From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: HDA intel, wired headset w/mic, jack mic detect
Date: Tue, 28 Feb 2012 18:00:21 +0000
Message-ID: <20120228180021.GC25472@sirena.org.uk>
References: <87ehtlwen3.fsf@ti.com> <4F472D4F.3000904@canonical.com>
	<CALyTGODsDRToe7efiHoVecvQ2JAYVj+G1Rv+upf2tBDDjPpzCg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id CB25D246CB
	for <alsa-devel@alsa-project.org>; Tue, 28 Feb 2012 19:00:22 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <CALyTGODsDRToe7efiHoVecvQ2JAYVj+G1Rv+upf2tBDDjPpzCg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Hilman, Kevin" <khilman@ti.com>
Cc: alsa-devel@alsa-project.org, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Feb 28, 2012 at 09:55:18AM -0800, Hilman, Kevin wrote:
> On Thu, Feb 23, 2012 at 10:25 PM, David Henningsson
> > On 02/23/2012 08:09 PM, Kevin Hilman wrote:

> >> I'm trying to get a wired headset with a mic working on MacBookAir
> >> running v3.0 (3.0.0-13-generic from Ubuntu to be precise.)

> > You can try upgrading your alsa version to the daily snapshot using this
> > method: https://wiki.ubuntu.com/Audio/UpgradingAlsa/DKMS

> It seems there's still a problem detecting that the headset also has a mic.

David, FWIW this is one of the systems I'm thinking of when I say that
headset is also an issue on HDA systems, not just for embedded devices.
