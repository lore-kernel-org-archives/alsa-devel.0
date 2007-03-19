From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: Development Question
Date: Mon, 19 Mar 2007 09:33:02 +0100
Message-ID: <1174293182.15615.1180145133@webmail.messagingengine.com>
References: <BAY120-F25C7398C33AE2729557D689C770@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <BAY120-F25C7398C33AE2729557D689C770@phx.gbl>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: "M. Gagnon" <fire_void@hotmail.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

M. Gagnon wrote:
> Okay, i tried with the docs. This is what i came up with, however i can't 
> seem to be able to play anything more than the first event, like time was 
> not moving, Perhaps i've missed something simple to make the time start?

What is the output of the program?
What are the contents of /proc/asound/seq/queues and .../timers while it's
trying to play?


Regards,
Clemens

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
