From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: RE: Announcing Linux driver for High-definition
 (aka Azalia) audio
Date: Thu, 08 Jul 2004 19:35:41 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <40ED93FD.2010500@superbug.demon.co.uk>
References: <B80241C0CEF2E948AEB4C7EBC775282F075EB26D@orsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <B80241C0CEF2E948AEB4C7EBC775282F075EB26D@orsmsx401.amr.corp.intel.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "Kogan, Dan D" <dan.d.kogan@intel.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Kogan, Dan D wrote:
> Greetings all,
> 
> I would like to announce the initial posting of a driver for Intel's
> High-Definition audio (formerly known as Azalia) to the ALSA community.
> 
<snip>
> Best regards,
> 
> Dan Kogan
> Intel Corp.
> Desktop Products Group
> Hillsboro, OR 
> 
> 

I just read the Intel HD audio spec.
Only supporting 8 output channels is a bit short sighted.

What about the following requirement: -
During a game:
7.1 audio output to speakers. <- Environmental audio effects.
stereo headset with mic for teamspeak. <- Simulate radio comms between 
members of the same online team.

That needs 10 output channels!

James


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
