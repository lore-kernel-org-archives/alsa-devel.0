From: "Lee Revell" <rlrevell@joe-job.com>
Subject: Re: patch: ac97_patch.c - enable 'Smart 5.1' on VIA
	vt1617a ac97 codec - Version 2
Date: Wed, 28 Feb 2007 15:54:56 -0500
Message-ID: <75b66ecd0702281254q5ce4e5d3i1d70182c6120e676@mail.gmail.com>
References: <F8FB97052F1BEF409F7842E960E49B5AAAF8BC@sea-exch-01.na.corp.dmxmusic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <F8FB97052F1BEF409F7842E960E49B5AAAF8BC@sea-exch-01.na.corp.dmxmusic.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: John Utz <John.Utz@dmxmusic.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On 2/28/07, John Utz <John.Utz@dmxmusic.com> wrote:
>  Note that the existing control Alternate Level to Surround Out may have to
> be disabled to hear the surround output.

Shouldn't you update the alsa-lib config file for this card with hooks
to do this automatically when the surround51 device is used?

Lee

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
