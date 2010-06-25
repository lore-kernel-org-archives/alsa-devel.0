From: Colin Guthrie <gmane@colin.guthr.ie>
Subject: Re: redirecting audio to another desktop machine
Date: Fri, 25 Jun 2010 10:34:37 +0100
Message-ID: <i01t7d$14j$1@dough.gmane.org>
References: <mailman.1.1277114401.21597.alsa-devel@alsa-project.org>,
	<4C1F4420.3060904@archlinux.us>	<70376CA23424B34D86F1C7DE6B9973430254343B42@VSHINMSMBX01.vshodc.lntinfotech.com>	<4C1F6E57.2060708@archlinux.us>
	<70376CA23424B34D86F1C7DE6B99734304E7B77FE9@VSHINMSMBX01.vshodc.lntinfotech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id 3ECAB1039BB
	for <alsa-devel@alsa-project.org>;
	Fri, 25 Jun 2010 11:34:49 +0200 (CEST)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1OS5J9-0005og-DS
	for alsa-devel@alsa-project.org; Fri, 25 Jun 2010 11:34:47 +0200
Received: from brent.tribalogic.net ([78.86.109.144])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Fri, 25 Jun 2010 11:34:47 +0200
Received: from gmane by brent.tribalogic.net with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Fri, 25 Jun 2010 11:34:47 +0200
In-Reply-To: <70376CA23424B34D86F1C7DE6B99734304E7B77FE9@VSHINMSMBX01.vshodc.lntinfotech.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

'Twas brillig, and Viral Mehta at 25/06/10 09:53 did gyre and gimble:
> Thanks for the reply.
> I think neither Pulse nor Rsound supports USB.


Hmm for clarity, you're talking about a communications from dev board to
host via USB, and nothing to do with USB Sound cards here right?

How does that comms work? Is it basically serial or some kind of IP over
USB? Is there any ethernet connectivity at all (even separate from the
main connection....)

I suspect that no-one can really answer until the details of the dev
board->host via USB are a little more clear.

Col


-- 

Colin Guthrie
gmane(at)colin.guthr.ie
http://colin.guthr.ie/

Day Job:
  Tribalogic Limited [http://www.tribalogic.net/]
Open Source:
  Mandriva Linux Contributor [http://www.mandriva.com/]
  PulseAudio Hacker [http://www.pulseaudio.org/]
  Trac Hacker [http://trac.edgewall.org/]
