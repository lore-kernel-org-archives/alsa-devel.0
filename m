From: Arve Knudsen <aknuds-1@broadpark.no>
Subject: Re: Re: weird thing: sound will skip sometimes with OSS in xmms but not if I use esound
Date: Thu, 08 Jan 2004 16:32:36 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <opr1gqsmv3q1sf88@mail.broadpark.no>
References: <1073571906.7370.2.camel@D5E03E8D.kabel.telenet.be> <yw1xk742h4zy.fsf@kth.se>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <yw1xk742h4zy.fsf@kth.se>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@kth.se>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

It could have to do with how the particular output plugin is written, or=20
the (in my opinion) somewhat retarded plugin model of xmms with sleeps=20
between writes to output.

Regards

Arve Knudsen

On Thu, 08 Jan 2004 15:47:13 +0100, M=E5ns Rullg=E5rd <mru@kth.se> wrote:

> Kristof vansant <de_lupus@pandora.be> writes:
>
>> Does esound do something special to keep sound stable?
>> It happens with snd-via82xx + OSS emulation.
>
> I'd rather think xmms does something that causes skips.  I've seen it
> with a cmi8738.  It's one of the reasons I stopped using xmms.  It's
> actually quite simple to play sound without skips.
>




-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
