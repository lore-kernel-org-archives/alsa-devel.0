From: Cezar <cezar@mixandgo.ro>
Subject: Re: symbol _snd_seq_hw_open is not defined
	inside	(null)
Date: Sun, 08 Oct 2006 19:58:42 +0300
Message-ID: <34579.4054250748$1160326715@news.gmane.org>
References: <871wpjgthv.fsf@mixandgo.ro> <1160323113.17615.97.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


aplaymidi file.mid requires a port

aplaymidi -p 0:0 file.mid says : 

Cannot connect to port 0:0 - Operation not permited

Lee Revell <rlrevell@joe-job.com> writes:

> On Sun, 2006-10-08 at 10:24 +0300, Cezar wrote:
>> Hello,
>> 
>> I am having problems creating alsa midi device in qsampler.
>> I get the following error:
>> 
>> An error box pops up that says :
>> 
>> New MIDI device
>> Could not create device
>> Sorry.
>
> Does "aplaymidi file.mid" work?  If so it's an application bug.
>
> Lee
>
>
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share your
> opinions on IT & business topics through brief surveys -- and earn cash
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
