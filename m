From: "Andrey Liakhovets" <liakh@dol.ru>
Subject: Re: [Openchrome-users] via epia boards sound quality
Date: Mon, 21 Aug 2006 00:15:32 +0400
Message-ID: <web-172094039@cgp.dol.ru>
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

James Courtier-Dutton wrote:
> Andrey Liakhovets wrote:
>> James Courtier-Dutton wrote:
>>> Andrey Liakhovets wrote:
>>>> In short, the attached 1-line patch against alsa 1.0.11 solves the problem
>>>>
>>>> If necessary, I can give more details or upload them on our ftp.
>>>>
>>>> Andrey Liakhovets
>>>
>>> Would you be able to provide 2 things?
>>>
>>> 1) Please add a "Signed-off-by:" entry.
>>> 2) Do you have the VT1616A datasheet?
>>>
>>> I can find the VT1616 datasheet online, but not the VT1616A.
>>>
>>> James
>>
>> No, I have only the VT1616 datasheet.
>>
>> Below I repeat the references, info and patch with my Signed-off-by.
>>
>
> So, with the absence of the VT1617A datasheet, we effectively have no
> documentation for that AC97 register touched in your patch.

Yes.

> Could I ask you to raise an alsa bug at
> https://bugtrack.alsa-project.org/alsa-bug/
>
> Enter into the bug everything from your updated email, with the sign off
> and attached patch.

https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2381

> I will then check the patch into the HG repository, but I will add a
> comment next to it pointing to the bug information. That way, future
> developers will know why it has been put there.
>
> James

Andrey Liakhovets

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
